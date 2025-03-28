// apps/auth-service/src/decorators/google-user.decorator.ts

import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export const GoogleUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext) => {
    // Obtenemos el request según la capa HTTP
    const request = ctx.switchToHttp().getRequest();
    // En la estrategia de Google, al validarse, se asigna request.user
    return request.user;
  },
);
