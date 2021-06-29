--高速决斗技能-墓孽生万物
Duel.LoadScript("speed_duel_common.lua")
function c100730291.initial_effect(c)
	--activate
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(c100730291.operation)
	e1:SetLabel(50164989)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
end

function c100730291.operation(e,tp,eg,ep,ev,re,r,rp)
	local id=e:GetLabel()
	tp = e:GetLabelObject():GetOwner()
	local c=Duel.CreateToken(tp,id)
	Duel.SendtoGrave(c,REASON_RULE)
	e:Reset()
end