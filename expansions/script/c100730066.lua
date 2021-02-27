--高速决斗技能-我的战士们
Duel.LoadScript("speed_duel_common.lua")
function c100730066.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730066.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730066.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	--atk up
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730066.tgfilter)
	e1:SetValue(500)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730066.tgfilter(e,c)
	return c:IsRace(RACE_WARRIOR) and c:IsLevel(4) and c:IsAttribute(ATTRIBUTE_EARTH)
end