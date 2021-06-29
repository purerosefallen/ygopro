--高速决斗技能-命运占卜师
Duel.LoadScript("speed_duel_common.lua")
function c100730234.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730234.skill,c100730234.con,aux.Stringid(100730234,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730234.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,1,nil,0x12e)
		and Duel.IsPlayerCanDraw(tp,1)
end
function c100730234.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730234)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_HAND,0,1,1,nil,0x12e)
	local c=g:GetFirst()
	if c then
		Duel.Draw(tp,1,REASON_RULE)
		Duel.ShuffleHand(tp)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
	end
end
