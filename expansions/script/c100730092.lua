--高速决斗技能-墓穴大军
Duel.LoadScript("speed_duel_common.lua")
function c100730092.initial_effect(c)
	if not c100730092.UsedLP then
		c100730092.UsedLP={}
		c100730092.UsedLP[0]=0
		c100730092.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730092.skill,c100730092.con,aux.Stringid(100730092,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730092.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730092.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,nil)
		and aux.DecreasedLP[tp]-c100730092.UsedLP[tp]>=1000
end
function c100730092.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730092)
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetTargetRange(LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetCode(EFFECT_CHANGE_RACE)
	e2:SetCondition(c100730092.condition)
	e2:SetReset(RESET_PHASE+PHASE_END,2)
	e2:SetValue(RACE_ZOMBIE)
	Duel.RegisterEffect(e2,tp)
end
function c100730092.filter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsRace(RACE_ZOMBIE)
end
function c100730092.condition(e)
	local tp=e:GetHandlerPlayer()
	return not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NECRO_VALLEY)
		and not Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_NECRO_VALLEY)
end
