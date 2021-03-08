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
		local c=Duel.CreateToken(tp,3078576)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,78706415)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,34124316)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,3280747)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,74191942)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		Duel.SendtoHand(g,tp,0,REASON_RULE)
		local g2=g:RandomSelect(tp,4)
		Duel.Exile(g2,REASON_RULE)
	end
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_DP)
	e1:SetTargetRange(1,0)
	if Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	end
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end