import { Entity, PrimaryColumn, ManyToOne, JoinColumn, Column } from 'typeorm';
import { User } from './user.entity';
import { Profession } from './profession.entity';

@Entity('user_profession')
export class UserProfession {
  @PrimaryColumn({ name: 'user_id' })
  userId!: number;

  @PrimaryColumn({ name: 'profession_id' })
  professionId!: number;

  @ManyToOne(() => User, user => user.userProfessions, {
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE'
  })
  @JoinColumn({ name: 'user_id' })
  user!: User;

  @ManyToOne(() => Profession, profession => profession.userProfessions, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE'
  })
  @JoinColumn({ name: 'profession_id' })
  profession!: Profession;

  // Campos adicionales
  @Column({ nullable: true })
  matricula?: string;

  @Column({ nullable: true })
  yearsExperience?: number;
}
