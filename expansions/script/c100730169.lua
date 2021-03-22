--高速决斗技能-鹰身的遗愿
Duel.LoadScript("speed_duel_common.lua")
function c100730169.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730169.skill,c100730169.con,aux.Stringid(100730169,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730169.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_GRAVE,0,2,nil,0x64)
end
function c100730169.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730169)
	local c=Duel.CreateToken(tp,18144506)
	Duel.SendtoHand(c,nil,REASON_RULE)
	Duel.ConfirmCards(1-tp,c)
	e:Reset()
end