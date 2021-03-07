--高速决斗技能-多说无益！
Duel.LoadScript("speed_duel_common.lua")
function c100730200.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730200.skill,c100730200.con,aux.Stringid(100730200,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730200.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<=4000
end
function c100730200.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730200,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730200)
		local c=Duel.CreateToken(tp,48130397)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end