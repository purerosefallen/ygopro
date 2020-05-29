--高速决斗技能-注定一抽
Duel.LoadScript("speed_duel_common.lua")
function c100730001.initial_effect(c)
	aux.SpeedDuelCalculateDecreasedLP()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCondition(c100730001.skillcond)
	e1:SetOperation(c100730001.skill)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730001.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730001,0)) then
		Duel.Hint(HINTMSG_SELECT,tp,aux.Stringid(100730001,1))
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_DECK,0,1,1,nil)
		if not g then return end
		Duel.MoveSequence(g:GetFirst(),0)
		c100730001.NotUsed = false
	end
end

function c100730001.skillcond(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp and aux.DecreasedLP[tp] >= 2000
end