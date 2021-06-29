--高速决斗技能-新生宇宙
Duel.LoadScript("speed_duel_common.lua")
function c100730190.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(43644025,c)
	aux.SpeedDuelMoveCardToFieldCommon(42015635,c)
	aux.SpeedDuelBeforeDraw(c,c100730190.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730190.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730190)
	local c=Duel.CreateToken(tp,80368942)
	Duel.SendtoHand(c,tp,REASON_RULE)
	local tc=Duel.CreateToken(tp,56641453)
	Duel.SSet(tp,tc)
	e:Reset()
end
