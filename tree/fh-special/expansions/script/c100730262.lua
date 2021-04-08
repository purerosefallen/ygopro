--高速决斗技能-巨人决战
Duel.LoadScript("speed_duel_common.lua")
function c100730262.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730262.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730262.bdcon(e)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)/2
end
function c100730262.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCondition(c100730262.bdcon)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e1:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	Duel.RegisterEffect(e1,c)
	e:Reset()
end