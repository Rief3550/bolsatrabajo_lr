import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { UserProfession } from './userProfession.entity';

@Entity('profession')
export class Profession {
  @PrimaryGeneratedColumn({ name: 'profession_id' })
  professionId!: number;

  @Column({ type: 'varchar', length: 100 })
  name!: string;

  @OneToMany(() => UserProfession, up => up.profession)
  userProfessions!: UserProfession[];
}
