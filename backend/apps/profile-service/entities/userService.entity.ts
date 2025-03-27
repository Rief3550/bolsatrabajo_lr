import { Entity, PrimaryColumn, ManyToOne, JoinColumn, Column } from 'typeorm';
import { User } from './user.entity';
import { ServiceEntity } from './service.entity';

@Entity('user_service')
export class UserServiceEntity {
  @PrimaryColumn({ name: 'user_id' })
  userId!: number;

  @PrimaryColumn({ name: 'service_id' })
  serviceId!: number;

  @ManyToOne(() => User, user => user.userServices, {
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE'
  })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @ManyToOne(() => ServiceEntity, service => service.userServices, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE'
  })
  @JoinColumn({ name: 'service_id' })
  service!: ServiceEntity;

  // Campos adicionales si querés
  @Column({ nullable: true })
  additionalInfo?: string;
}
