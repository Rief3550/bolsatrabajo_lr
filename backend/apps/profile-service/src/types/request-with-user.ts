// apps/profile-service/src/types/request-with-user.ts
import { Request } from '@nestjs/common';

// Podés cambiar el import a 'express' si querés
// import { Request } from 'express';

export interface RequestWithUser extends Request {
  user?: {
    userId: number;
    // otros campos si deseas
  };
}
