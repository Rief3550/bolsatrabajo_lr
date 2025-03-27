import { Controller, Put, Post, Body, Req } from '@nestjs/common';
import { ProfileServiceService } from './profile-service.service';
import { AddProfessionsDto } from '../dtos/add-professions.dto';
import { UpdateBasicInfoDto } from '../dtos/update-basic-info.dto';
import { RequestWithUser } from './types/request-with-user';
 // ruta hipotética

@Controller('profile')
export class ProfileServiceController {
  constructor(private readonly profileService: ProfileServiceService) {}

  @Put('basic-info')
  updateBasicInfo(@Req() req: RequestWithUser, @Body() dto: UpdateBasicInfoDto) {
    if (!req.user) {
      throw new Error('User information is missing in the request.');
    }
    return this.profileService.updateBasicInfo(req.user.userId, dto);
  }

  @Post('professions')
  addProfessions(@Req() req: RequestWithUser, @Body() dto: AddProfessionsDto) {
    if (!req.user) {
      throw new Error('User information is missing in the request.');
    }
    return this.profileService.addUserProfessions(req.user.userId, dto.professions);
  }

  @Post('services')
  addServices(@Req() req: RequestWithUser, @Body() dto: { services: { serviceId: number, additionalInfo?: string }[] }) {
    if (!req.user) {
      throw new Error('User information is missing in the request.');
    }
    return this.profileService.addUserServices(req.user.userId, dto.services);
  }
}
