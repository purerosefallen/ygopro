--高速决斗技能-骰子回归
Duel.LoadScript("speed_duel_common.lua")
function c100730310.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730310.skill,c100730310.con,aux.Stringid(100730310,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730310.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,nil)
end
function c100730310.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,nil)
	local ct=Duel.TossDice(tp,1)
	local c=g:Select(tp,1,ct,nil)
	if c then
		Duel.Hint(HINT_CARD,1-tp,100730310)
		Duel.HintSelection(c)
		Duel.SendtoDeck(c,nil,0,REASON_EFFECT)
		e:Reset()
	end
end