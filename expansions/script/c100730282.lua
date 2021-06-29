--高速决斗技能-攻击助推器：同调战士
Duel.LoadScript("speed_duel_common.lua")
function c100730282.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730282.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730282.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730282.tgfilter)
	e1:SetValue(c100730282.val)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730282.tgfilter(e,c)
	return c:IsSetCard(0x66) and c:IsType(TYPE_SYNCHRO)
end

function c100730282.val(e,c)
	return c:GetLevel()*100
end
