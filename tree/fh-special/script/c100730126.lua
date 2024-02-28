--高速决斗技能-进化后的最强龙族
Duel.LoadScript("speed_duel_common.lua")
function c100730126.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(23995346,c)
	aux.SpeedDuelMoveCardToDeckCommon(56532353,c)
	aux.SpeedDuelMoveCardToDeckCommon(2129638,c)
	aux.SpeedDuelMoveCardToDeckCommon(43228023,c)
	aux.SpeedDuelAtMainPhase(c,c100730126.skill,c100730126.con,aux.Stringid(100730106,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730126.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,3,nil,89631139)
end
function c100730126.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,89631139)
	local g2=g:Select(tp,3,3,nil)
	if g2 then
		Duel.ConfirmCards(1-tp,g2)
		Duel.Hint(HINT_CARD,1-tp,100730126)
		local d=Duel.CreateToken(tp,24094653)
		Duel.SendtoHand(d,nil,REASON_RULE)
	end
end