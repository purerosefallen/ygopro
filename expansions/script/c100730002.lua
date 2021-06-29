--高速决斗技能-皇家同花顺
Duel.LoadScript("speed_duel_common.lua")
function c100730002.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730002.skill,c100730002.con,aux.Stringid(100730106,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730002.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,64788463)
end
function c100730002.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,1,nil,64788463)
	local c=g:Select(tp,1,3,nil)
	if c then
		Duel.ConfirmCards(1-tp,c)
		Duel.Hint(HINT_CARD,1-tp,100730002)
		Duel.PayLPCost(tp,1000)
		local d=Duel.CreateToken(tp,25652259)
		Duel.SpecialSummon(d,0,tp,tp,true,true,POS_FACEUP)
		local d2=Duel.CreateToken(tp,74335036)
		Duel.SendtoHand(d2,nil,REASON_RULE)
	e:Reset()
	end
end