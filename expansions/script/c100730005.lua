--高速决斗技能-新生宇宙
Duel.LoadScript("speed_duel_common.lua")
function c100730005.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(42015635,c)
	aux.SpeedDuelBeforeDraw(c,c100730005.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730005.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730005)
	local c=Duel.CreateToken(tp,47274077)
	Duel.SendtoHand(c,tp,REASON_RULE)
	e:Reset()
end
