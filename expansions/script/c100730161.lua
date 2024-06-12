--高速决斗技能-不朽的印记
Duel.LoadScript("speed_duel_common.lua")
function c100730161.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730161.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730161.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730161.tgfilter)
	e1:SetValue(c100730161.efilter)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730161.tgfilter(e,c)
	return c:IsSetCard(0x21)
end
function c100730161.efilter(e,re,rp,c)
	return re:GetOwner()==c
end
