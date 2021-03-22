--高速决斗技能-科技属助推器
Duel.LoadScript("speed_duel_common.lua")
function c100730152.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730152.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730152.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730152.tgfilter)
	e1:SetValue(c100730152.val)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730152.tgfilter(e,c)
	return c:IsSetCard(0x27)
end

function c100730152.val(e,c)
	return c:GetLevel()*150
end
