--高速决斗技能-创造者
Duel.LoadScript("speed_duel_common.lua")
function c100730201.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730201.skill,c100730201.con,aux.Stringid(100730201,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730201.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<=2000
end
function c100730201.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730201,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730201)
		local g=Group.CreateGroup()
		local c=Duel.CreateToken(tp,83764718)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,18144506)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,79571449)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		Duel.SendtoDeck(g,tp,0,REASON_RULE)
		local g2=g:RandomSelect(tp,2)
		Duel.Exile(g2,REASON_RULE)
		e:Reset()
	end
end