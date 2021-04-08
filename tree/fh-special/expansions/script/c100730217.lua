--高速决斗技能-虫群革命
Duel.LoadScript("speed_duel_common.lua")
function c100730217.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730217.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730217.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	--atk up
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c100730217.kaicon)
	e1:SetTarget(c100730217.cfilter)
	e1:SetValue(-800)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730217.cfilter(e,c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c100730217.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsRace(RACE_INSECT)
end
function c100730217.kaicon(e,tp)
	return Duel.IsExistingMatchingCard(c100730217.filter,tp,LOCATION_MZONE+LOCATION_SZONE,LOCATION_MZONE+LOCATION_SZONE,3,nil)
end