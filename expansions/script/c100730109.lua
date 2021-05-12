--高速决斗技能-吃点决斗饭团！
Duel.LoadScript("speed_duel_common.lua")
function c100730109.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730109.skill,c100730109.con,aux.Stringid(100730109,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730109.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,2,nil,RACE_FAIRY)
end
function c100730109.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,nil,RACE_FAIRY)
	local c=g:Select(tp,2,4,nil)
	if c then
		Duel.Hint(HINT_CARD,1-tp,100730109)
		Duel.HintSelection(c)
		Duel.SendtoDeck(c,nil,0,REASON_EFFECT)
		Duel.Recover(tp,2000,REASON_EFFECT)   
	e:Reset()
	end
end