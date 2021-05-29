--高速决斗技能-仪式典礼
Duel.LoadScript("speed_duel_common.lua")
function c100730195.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730195.skill,c100730195.con,aux.Stringid(100730195,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730195.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730195.filter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,13048472)
end
function c100730195.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730195)
	local g=Duel.SelectMatchingCard(tp,c100730195.filter,tp,LOCATION_HAND,0,1,1,nil,tp)
	Duel.ConfirmCards(1-tp,g)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,13048472)
	Duel.SendtoHand(g1,tp,REASON_RULE)
end
function c100730195.filter(c)
	return bit.band(c:GetType(),0x81)==0x81
end