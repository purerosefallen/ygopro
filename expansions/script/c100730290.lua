--高速决斗技能-黑蔷薇风暴
Duel.LoadScript("speed_duel_common.lua")
function c100730290.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(84335863,c)
	aux.SpeedDuelBeforeDraw(c,c100730290.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730290.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetLabelObject()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730290.filter)
	e1:SetValue(c100730290.efilter)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730290.filter(e,c)
	return c:IsCode(73580471)
end
function c100730290.efilter(e,re,rp,c)
	return re:GetOwner()==c
end