package logger

import (
	"go.uber.org/zap"
)

type IAppLogger interface {
	init()
	Fatal(string, ...zap.Field)
	Info(string, ...zap.Field)
	Debug(string, ...zap.Field)
	Error(string, ...zap.Field)
}

type DefaultAppLogger struct {
	Logger IAppLogger
}

var appLogger DefaultAppLogger = DefaultAppLogger{Logger: ZapAppLogger{}}

func Shared() *DefaultAppLogger {
	return &appLogger
}
func (s DefaultAppLogger) Init() {
	s.Logger.init()
}
