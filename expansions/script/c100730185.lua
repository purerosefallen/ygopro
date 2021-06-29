--高速决斗技能-魔术大师
Duel.LoadScript("speed_duel_common.lua")
function c100730185.initial_effect(c)
	if not c100730185.UsedLP then
		c100730185.UsedLP={}
		c100730185.UsedLP[0]=0
		c100730185.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730185.skill,c100730185.con,aux.Stringid(100730185,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730185.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and aux.DecreasedLP[tp]-c100730185.UsedLP[tp]>=2000
		and Duel.IsExistingMatchingCard(c100730185.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil)
end
function c100730185.filter(c)
	return c:IsCode(63391643,2314238,111280) and c:IsAbleToHand()
end
function c100730185.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730185.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoHand(g:GetFirst(),tp,REASON_EFFECT)
	local c=Duel.CreateToken(tp,67227834)
	Duel.SendtoHand(c,nil,REASON_RULE)
end