--高速决斗技能-天使的微笑
Duel.LoadScript("speed_duel_common.lua")
function c100730044.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730044.skill,c100730044.con,aux.Stringid(100730044,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730044.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_HAND,0,1,nil,RACE_FAIRY)
end
function c100730044.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,1,nil,RACE_FAIRY)
	local g1=g:Select(tp,1,1,nil)
	if g1 then
		Duel.ConfirmCards(1-tp,g1)
		local lp=Duel.GetLP(tp)
		Duel.SetLP(tp,lp+1000)
	end
end