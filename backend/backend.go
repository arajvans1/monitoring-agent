package backend

type Backend interface {
	Execute(command string) (any, error)
}
