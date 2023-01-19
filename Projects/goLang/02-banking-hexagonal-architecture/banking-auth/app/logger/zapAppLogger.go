package logger

import (
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

var log *zap.Logger

type ZapAppLogger struct {
}

func (s ZapAppLogger) init() {
	var err error
	// log, err = zap.NewProductionConfig().Build(zap.AddCallerSkip(1))

	config := zap.NewProductionConfig()
	encoderConfig := zap.NewProductionEncoderConfig()
	encoderConfig.TimeKey = "timeStamp"
	encoderConfig.EncodeTime = zapcore.ISO8601TimeEncoder
	encoderConfig.StacktraceKey = ""
	config.EncoderConfig = encoderConfig

	log, err = config.Build(zap.AddCallerSkip(1))
	if err != nil {
		panic(err)
	}

	log.Info("Logger initialised")
}
func (s ZapAppLogger) Info(message string, fields ...zap.Field) {
	log.Info(message, fields...)
}
func (s ZapAppLogger) Debug(message string, fields ...zap.Field) {
	log.Debug(message, fields...)
}
func (s ZapAppLogger) Error(message string, fields ...zap.Field) {
	log.Error(message, fields...)
}
func (s ZapAppLogger) Fatal(message string, fields ...zap.Field) {
	log.Fatal(message, fields...)
}
