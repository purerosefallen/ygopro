--高速决斗技能-攻击助推器：lv2
Duel.LoadScript("speed_duel_common.lua")
function c100730280.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730280.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730280.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	--atk up
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730280.tgfilter)
	e1:SetValue(700)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730280.tgfilter(e,c)
	return c:IsLevelBelow(2)
end