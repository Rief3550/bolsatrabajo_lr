import { IsInt, IsOptional, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export class ProfessionData {
  @IsInt()
  professionId!: number;

  @IsOptional()
  matricula?: string;

  @IsOptional()
  yearsExperience?: number;
}

export class AddProfessionsDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ProfessionData)
  professions!: ProfessionData[];
}
