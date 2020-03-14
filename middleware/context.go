package middleware

import (
	"net/http"

	"github.com/labstack/echo"

	"github.com/acm-uiuc/core/context"
	"github.com/acm-uiuc/core/service"
)

func Context(svc *service.Service) func(echo.HandlerFunc) echo.HandlerFunc {
	return func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(ctx echo.Context) error {
			token := ctx.Request().Header.Get("Authorization")

			username, err := svc.Auth.Verify(token)
			if err != nil {
				return ctx.String(http.StatusForbidden, "Invalid Authorization Token")
			}

			extCtx := &context.Context{
				Context:  ctx,
				Username: username,
			}

			return next(extCtx)
		}
	}
}