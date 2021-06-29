--高速决斗技能-生命支付0
Duel.LoadScript("speed_duel_common.lua")
function c100730025.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730025.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730025.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_LPCOST_CHANGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCondition(c100730025.con)
	e2:SetTargetRange(1,0)
	e2:SetValue(0)
	Duel.RegisterEffect(e2,tp)
end
function c100730025.con(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetLP(tp)<=2500
end