--高速决斗技能-电子化天使的祝福
Duel.LoadScript("speed_duel_common.lua")
function c100730094.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730094.skill,c100730094.con,aux.Stringid(100730094,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730094.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<=5000
end
function c100730094.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730094,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730094)
		local c=Duel.CreateToken(tp,77235086)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end