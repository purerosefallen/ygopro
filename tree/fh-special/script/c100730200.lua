--高速决斗技能-终极融合！
Duel.LoadScript("speed_duel_common.lua")
function c100730200.initial_effect(c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(c100730200.skill2)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
	aux.SpeedDuelReplaceDraw(c,c100730200.skill,c100730200.con,aux.Stringid(100730200,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730200.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<=3500
end
function c100730200.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730200,0)) then
		local c=Duel.CreateToken(tp,48130397)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end
function c100730200.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	local c=Duel.CreateToken(tp,31764700)
	g:AddCard(c)
	aux.CardAddedBySkill:AddCard(c)
	c=Duel.CreateToken(tp,4779091)
	g:AddCard(c)
	aux.CardAddedBySkill:AddCard(c)
	c=Duel.CreateToken(tp,78371393)
	g:AddCard(c)
	aux.CardAddedBySkill:AddCard(c)
	Duel.SendtoGrave(g,REASON_RULE)
	e:Reset()
end