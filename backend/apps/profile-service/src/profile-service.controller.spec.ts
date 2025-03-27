import { Test, TestingModule } from '@nestjs/testing';
import { ProfileServiceController } from './profile-service.controller';
import { ProfileServiceService } from './profile-service.service';

describe('ProfileServiceController', () => {
  let profileController: ProfileServiceController;
  let profileService: ProfileServiceService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ProfileServiceController],
      providers: [
        {
          provide: ProfileServiceService,
          useValue: {
            // Podés mockear acá los métodos que uses en el controller, por ejemplo:
            updateBasicInfo: jest.fn().mockResolvedValue({ /* objeto simulado */ }),
            addUserProfessions: jest.fn().mockResolvedValue({ message: 'OK' }),
            // etc.
          },
        },
      ],
    }).compile();

    profileController = module.get<ProfileServiceController>(ProfileServiceController);
    profileService = module.get<ProfileServiceService>(ProfileServiceService);
  });

  it('should be defined', () => {
    expect(profileController).toBeDefined();
  });

  describe('updateBasicInfo', () => {
    it('should call service and return updated user', async () => {
      const dto = { firstName: 'Fede', lastName: 'Riera' };
      // Llamada al controller
      const result = await profileController.updateBasicInfo({ user: { userId: 1 } } as any, dto);
      expect(profileService.updateBasicInfo).toHaveBeenCalledWith(1, dto);
      // Verificá que 'result' sea lo que el mock retorne
    });
  });
  
  describe('addProfessions', () => {
    it('should call service and return OK message', async () => {
      const dto = { professions: [{ professionId: 1, matricula: 'ABC123' }] };
      const result = await profileController.addProfessions({ user: { userId: 1 } } as any, dto);
      expect(profileService.addUserProfessions).toHaveBeenCalledWith(1, dto.professions);
      expect(result).toEqual({ message: 'OK' }); // asumiendo que el mock resolvedValue era { message: 'OK' }
    });
  });
});
