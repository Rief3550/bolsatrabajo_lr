// apps/profile-service/dtos/update-basic-info.dto.ts
import { IsOptional, IsString, IsInt } from 'class-validator';

export class UpdateBasicInfoDto {
  @IsOptional()
  @IsString()
  firstName?: string;

  @IsOptional()
  @IsString()
  lastName?: string;

  @IsOptional()
  @IsString()
  domicilio?: string;

  @IsOptional()
  @IsInt()
  edad?: number;

  @IsOptional()
  @IsString()
  profileSummary?: string;
}
