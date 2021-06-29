--高速决斗技能-创造者
Duel.LoadScript("speed_duel_common.lua")
function c100730121.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730121.skill,c100730121.con,aux.Stringid(100730121,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730121.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<=4000
end
function c100730121.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730121,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730121)
		local d=Duel.TossDice(tp,1) 
		if d==6 then
			local c=Duel.CreateToken(tp,3280747)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		elseif d==1 then
			local c=Duel.CreateToken(tp,78706415)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		elseif d==2 then
			local c=Duel.CreateToken(tp,34124316)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		elseif d>=3 and d<=5 then
			local c=Duel.CreateToken(tp,3078576)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		end
	e:Reset()
	end
end