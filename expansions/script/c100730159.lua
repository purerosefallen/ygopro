--高速决斗技能-在前线作战
Duel.LoadScript("speed_duel_common.lua")
function c100730159.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730159.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730159.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	--atk up
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730159.tgfilter)
	e1:SetValue(650)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100730159.tgfilter)
	e2:SetValue(650)
	Duel.RegisterEffect(e2,tp)
end
function c100730159.tgfilter(e,c)
	return c:IsRace(RACE_PYRO)
end