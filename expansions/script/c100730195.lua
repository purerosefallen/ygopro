--高速决斗技能-紧急呼唤
Duel.LoadScript("speed_duel_common.lua")
function c100730195.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730195.skill,c100730195.con,aux.Stringid(100730195,0))
	aux.SpeedDuelBeforeDraw(c,c100730195.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730195.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<=4000
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,1,nil,0x3008)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,0x3008)
end
function c100730195.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_HAND,0,nil,0x3008)
	local g2=g:Select(tp,1,1,nil)
	Duel.Hint(HINT_CARD,1-tp,100730195)
	if g2 then
		Duel.ConfirmCards(1-tp,g2)
		local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,0x3008)
		local tc=g:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_RULE)
		Duel.ConfirmCards(1-tp,tc)
	end
	e:Reset()
end