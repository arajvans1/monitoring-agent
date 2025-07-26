package backend

import (
	"context"
	"database/sql"
	"time"

	_ "github.com/SAP/go-hdb/driver"
)

type SQLBackend struct {
	db *sql.DB
}

func NewSQLBackend(dsn string) *SQLBackend {
	db, err := sql.Open("hdb", dsn)
	if err != nil {
		panic(err) // config or network issue — fail fast
	}
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(5)
	db.SetConnMaxLifetime(30 * time.Minute)
	return &SQLBackend{db: db}
}

func (s *SQLBackend) Execute(command string) (any, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	rows, err := s.db.QueryContext(ctx, command)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	cols, _ := rows.Columns()
	results := []map[string]any{}

	for rows.Next() {
		vals := make([]any, len(cols))
		ptrs := make([]any, len(cols))
		for i := range vals {
			ptrs[i] = &vals[i]
		}
		if err := rows.Scan(ptrs...); err != nil {
			return nil, err
		}
		rowMap := make(map[string]any)
		for i, col := range cols {
			rowMap[col] = vals[i]
		}
		results = append(results, rowMap)
	}
	return results, nil
}
