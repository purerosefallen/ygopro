--高速决斗技能-创造者
Duel.LoadScript("speed_duel_common.lua")
function c100730201.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730201.skill,c100730201.con,aux.Stringid(100730201,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730201.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<=4000
end
function c100730201.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730201,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730201)
		local count=Duel.TossCoin(tp,4)
		if count==4 then
			local c=Duel.CreateToken(tp,3280747)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		elseif count==3 then
			local c=Duel.CreateToken(tp,78706415)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		elseif count==2 then
			local c=Duel.CreateToken(tp,34124316)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		elseif count==1 then
			local c=Duel.CreateToken(tp,3078576)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		elseif count==0 then
			local c=Duel.CreateToken(tp,18144506)
			Duel.SendtoDeck(c,tp,0,REASON_RULE)
		end
	end
end