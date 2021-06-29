--高速决斗技能-别找借口！
Duel.LoadScript("speed_duel_common.lua")
function c100730318.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730318.skill,c100730318.con,aux.Stringid(100730318,1))
	aux.SpeedDuelMoveCardToFieldCommon(63477921,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730318.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<=4000
end
function c100730318.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730318,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730318)
		local c=Duel.CreateToken(tp,37630732)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end