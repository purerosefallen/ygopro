--高速决斗技能-代偿
Duel.LoadScript("speed_duel_common.lua")
function c100730257.initial_effect(c)
	if not c100730257.UsedLP then
		c100730257.UsedLP={}
		c100730257.UsedLP[0]=0
		c100730257.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730257.skill,c100730257.con,aux.Stringid(100730257,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730257.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730257.filter,tp,LOCATION_DECK,0,1,nil)
		and aux.DecreasedLP[tp]-c100730257.UsedLP[tp]>=1000
end
function c100730257.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730257)
	local g=Duel.GetMatchingGroup(c100730257.filter,tp,LOCATION_DECK,0,1,nil)
	local g2=g:RandomSelect(tp,1)
	if g2:GetCount()>0 then
		Duel.SendtoGrave(g2,REASON_EFFECT)
		Duel.Recover(tp,300,REASON_EFFECT)
	end
end
function c100730257.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
