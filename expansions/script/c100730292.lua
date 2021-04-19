--高速决斗技能-魔术女孩防御
Duel.LoadScript("speed_duel_common.lua")
function c100730292.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(89448140,c)
	aux.SpeedDuelBeforeDraw(c,c100730292.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730292.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCondition(c100730292.kaicon)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c100730292.damval)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730292.damval(e,re,val,r,rp,rc)
	return math.floor(val/2)
end
function c100730292.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x20a2)
end
function c100730292.kaicon(e,tp)
	return Duel.IsExistingMatchingCard(c100730292.filter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil)
end