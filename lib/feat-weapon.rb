## breakout for Weapon and Feat released with PSM3
## new code for 5.0.16
## includes new functions .known? and .affordable?

class Feat
  @@absorb_magic                  ||= 0
  @@chain_armor_proficiency       ||= 0
  @@combat_mastery                ||= 0
  @@critical_counter              ||= 0
  @@dispel_magic                  ||= 0
  @@dragonscale_skin              ||= 0
  @@guard                         ||= 0
  @@kroderine_soul                ||= 0
  @@light_armor_proficiency       ||= 0
  @@martial_arts_mastery          ||= 0
  @@martial_mastery               ||= 0
  @@mental_acuity                 ||= 0
  @@mystic_strike                 ||= 0
  @@perfect_self                  ||= 0
  @@plate_armor_proficiency       ||= 0
  @@protect                       ||= 0
  @@scale_armor_proficiency       ||= 0
  @@shadow_dance                  ||= 0
  @@silent_strike                 ||= 0
  @@vanish                        ||= 0
  @@weapon_bonding                ||= 0

  def Feat.absorb_magic;              @@absorb_magic;             end
  def Feat.chain_armor_proficiency;   @@chain_armor_proficiency;  end
  def Feat.combat_mastery;            @@combat_mastery;           end
  def Feat.critical_counter;          @@critical_counter;         end
  def Feat.dispel_magic;              @@dispel_magic;             end
  def Feat.dragonscale_skin;          @@dragonscale_skin;         end
  def Feat.guard;                     @@guard;                    end
  def Feat.kroderine_soul;            @@kroderine_soul;           end
  def Feat.light_armor_proficiency;   @@light_armor_proficiency;  end
  def Feat.martial_arts_mastery;      @@martial_arts_mastery;     end
  def Feat.martial_mastery;           @@martial_mastery;          end
  def Feat.mental_acuity;             @@mental_acuity;            end
  def Feat.mystic_strike;             @@mystic_strike;            end
  def Feat.perfect_self;              @@perfect_self;             end
  def Feat.plate_armor_proficiency;   @@plate_armor_proficiency;  end
  def Feat.protect;                   @@protect;                  end
  def Feat.scale_armor_proficiency;   @@scale_armor_proficiency;  end
  def Feat.shadow_dance;              @@shadow_dance;             end
  def Feat.silent_strike;             @@silent_strike;            end
  def Feat.vanish;                    @@vanish;                   end
  def Feat.weapon_bonding;            @@weapon_bonding;           end

  def Feat.absorb_magic=(val);              @@absorb_magic=val;             end
  def Feat.chain_armor_proficiency=(val);   @@chain_armor_proficiency=val;  end
  def Feat.combat_mastery=(val);            @@combat_mastery=val;           end
  def Feat.critical_counter=(val);          @@critical_counter=val;         end
  def Feat.dispel_magic=(val);              @@dispel_magic=val;             end
  def Feat.dragonscale_skin=(val);          @@dragonscale_skin=val;         end
  def Feat.guard=(val);                     @@guard=val;                    end
  def Feat.kroderine_soul=(val);            @@kroderine_soul=val;           end
  def Feat.light_armor_proficiency=(val);   @@light_armor_proficiency=val;  end
  def Feat.martial_arts_mastery=(val);      @@martial_arts_mastery=val;     end
  def Feat.martial_mastery=(val);           @@martial_mastery=val;          end
  def Feat.mental_acuity=(val);             @@mental_acuity=val;            end
  def Feat.mystic_strike=(val);             @@mystic_strike=val;            end
  def Feat.perfect_self=(val);              @@perfect_self=val;             end
  def Feat.plate_armor_proficiency=(val);   @@plate_armor_proficiency=val;  end
  def Feat.protect=(val);                   @@protect=val;                  end
  def Feat.scale_armor_proficiency=(val);   @@scale_armor_proficiency=val;  end
  def Feat.shadow_dance=(val);              @@shadow_dance=val;             end
  def Feat.silent_strike=(val);             @@silent_strike=val;            end
  def Feat.vanish=(val);                    @@vanish=val;                   end
  def Feat.weapon_bonding=(val);            @@weapon_bonding=val;           end

  @@cost_hash = Hash.new
  @@cost_hash = { "absorb_magic" => 0, "chain_armor_proficiency" => 0, "combat_mastery" => 0, "critical_counter" => 0, "dispel_magic" => 0, "dragonscale_skin" => 0, "guard" => 0, "kroderine_soul" => 0, "light_armor_proficiency" => 0, "martial_arts_mastery" => 0, "martial_mastery" => 0, "mental_acuity" => 0, "mystic_strike" => 10, "perfect_self" => 0, "plate_armor_proficiency" => 0, "protect" => 0, "scale_armor_proficiency" => 0, "shadow_dance" => 30, "silent_strike" => 20, "vanish" => 30, "weapon_bonding" => 0 }

  def Feat.method_missing(arg1, arg2=nil)
    nil
  end
  def Feat.[](name)
    Feat.send(name.gsub(/[\s\-]/, '_').gsub("'", "").downcase)
  end
  def Feat.[]=(name,val)
    Feat.send("#{name.gsub(/[\s\-]/, '_').gsub("'", "").downcase}=", val.to_i)
  end

  def Feat.known?(name)
    Feat.send(name.gsub(/[\s\-]/, '_').gsub("'", "").downcase) > 0
  end

  def Feat.affordable?(name)
    @@cost_hash.fetch(name) < XMLData.stamina
  end

end

class Weapon
  @@barrage                  ||=0
  @@charge                   ||=0
  @@clash                    ||=0
  @@clobber                  ||=0
  @@cripple                  ||=0
  @@cyclone                  ||=0
  @@dizzying_swing           ||=0
  @@flurry                   ||=0
  @@fury                     ||=0
  @@guardant_thrusts         ||=0
  @@overpower                ||=0
  @@pin_down                 ||=0
  @@pulverize                ||=0
  @@pummel                   ||=0
  @@radial_sweep             ||=0
  @@reactive_shot            ||=0
  @@reverse_strike           ||=0
  @@riposte                  ||=0
  @@spin_kick                ||=0
  @@thrash                   ||=0
  @@twin_hammerfists         ||=0
  @@volley                   ||=0
  @@whirling_blade           ||=0
  @@whirlwind                ||=0

  def Weapon.barrage;           @@barrage;              end
  def Weapon.charge;            @@charge;               end
  def Weapon.clash;             @@clash;                end
  def Weapon.clobber;           @@clobber;              end
  def Weapon.cripple;           @@cripple;              end
  def Weapon.cyclone;           @@cyclone;              end
  def Weapon.dizzying_swing;    @@dizzying_swing;       end
  def Weapon.flurry;            @@flurry;               end
  def Weapon.fury;              @@fury;                 end
  def Weapon.guardant_thrusts;  @@guardant_thrusts;     end
  def Weapon.overpower;         @@overpower;            end
  def Weapon.pin_down;          @@pin_down;             end
  def Weapon.pulverize;         @@pulverize;            end
  def Weapon.pummel;            @@pummel;               end
  def Weapon.radial_sweep;      @@radial_sweep;         end
  def Weapon.reactive_shot;     @@reactive_shot;        end
  def Weapon.reverse_strike;    @@reverse_strike;       end
  def Weapon.riposte;           @@riposte;              end
  def Weapon.spin_kick;         @@spin_kick;            end
  def Weapon.thrash;            @@thrash;               end
  def Weapon.twin_hammerfists;  @@twin_hammerfists;     end
  def Weapon.volley;            @@volley;               end
  def Weapon.whirling_blade;    @@whirling_blade;       end
  def Weapon.whirlwind;         @@whirlwind;            end

  def Weapon.barrage=(val);             @@barrage=val;              end
  def Weapon.charge=(val);              @@charge=val;               end
  def Weapon.clash=(val);               @@clash=val;                end
  def Weapon.clobber=(val);             @@clobber=val;              end
  def Weapon.cripple=(val);             @@cripple=val;              end
  def Weapon.cyclone=(val);             @@cyclone=val;              end
  def Weapon.dizzying_swing=(val);      @@dizzying_swing=val;       end
  def Weapon.flurry=(val);              @@flurry=val;               end
  def Weapon.fury=(val);                @@fury=val;                 end
  def Weapon.guardant_thrusts=(val);    @@guardant_thrusts=val;     end
  def Weapon.overpower=(val);           @@overpower=val;            end
  def Weapon.pin_down=(val);            @@pin_down=val;             end
  def Weapon.pulverize=(val);           @@pulverize=val;            end
  def Weapon.pummel=(val);              @@pummel=val;               end
  def Weapon.radial_sweep=(val);        @@radial_sweep=val;         end
  def Weapon.reactive_shot=(val);       @@reactive_shot=val;        end
  def Weapon.reverse_strike=(val);      @@reverse_strike=val;       end
  def Weapon.riposte=(val);             @@riposte=val;              end
  def Weapon.spin_kick=(val);           @@spin_kick=val;            end
  def Weapon.thrash=(val);              @@thrash=val;               end
  def Weapon.twin_hammerfists=(val);    @@twin_hammerfists=val;     end
  def Weapon.volley=(val);              @@volley=val;               end
  def Weapon.whirling_blade=(val);      @@whirling_blade=val;       end
  def Weapon.whirlwind=(val);           @@whirlwind=val;            end

  @@cost_hash = Hash.new
  @@cost_hash = { "barrage" => 15, "charge" => 14, "clash" => 20, "clobber" => 0, "cripple" => 7, "cyclone" => 20, "dizzying_swing" => 7, "flurry" => 15, "fury" => 15, "guardant_thrusts" => 15, "overpower" => 0, "pin_down" => 14, "pulverize" => 20, "pummel" => 15, "radial_sweep" => 0, "reactive_shot" => 0, "reverse_strike" => 0, "riposte" => 0, "spin_kick" => 0, "thrash" => 15, "twin_hammerfists" => 7, "volley" => 20, "whirling_blade" => 20, "whirlwind" => 20 }

  def Weapon.method_missing(arg1, arg2=nil)
    nil
  end
  def Weapon.[](name)
    Weapon.send(name.gsub(/[\s\-]/, '_').gsub("'", "").downcase)
  end
  def Weapon.[]=(name,val)
    Weapon.send("#{name.gsub(/[\s\-]/, '_').gsub("'", "").downcase}=", val.to_i)
  end

  def Weapon.known?(name)
    Weapon.send(name.gsub(/[\s\-]/, '_').gsub("'", "").downcase) > 0
  end

  def Weapon.affordable?(name)
    @@cost_hash.fetch(name) < XMLData.stamina
  end

end
