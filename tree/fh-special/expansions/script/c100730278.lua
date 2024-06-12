--高速决斗技能-耐魔法装甲
Duel.LoadScript("speed_duel_common.lua")
function c100730278.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730278.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730278.filter(c)
	return c:IsRace(RACE_MACHINE) and c:IsType(TYPE_NORMAL)
end
function c100730278.nttg(e,c)
	return c:IsRace(RACE_MACHINE) and c:IsType(TYPE_NORMAL)
end
function c100730278.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetLabelObject()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730278.efilter)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetCondition(c100730278.con)
	e1:SetValue(c100730278.imfilter)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100730278,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetTarget(c100730278.nttg)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100730278,1))
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetTargetRange(LOCATION_HAND,0)
	e3:SetCode(EFFECT_SUMMON_PROC)
	e3:SetTarget(c100730278.nttg)
	Duel.RegisterEffect(e3,tp)
	e:Reset()
end
function c100730278.con(e)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	if g:GetClassCount(Card.GetOriginalRace)>1 then return false end
	return Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_GRAVE,0,1,nil,RACE_MACHINE) or g:GetCount()==0
end
function c100730278.efilter(e,c)
	return c:IsRace(RACE_MACHINE) and c:IsFaceup()
end
function c100730278.imfilter(e,re)
	return re:IsActiveType(TYPE_SPELL)
end