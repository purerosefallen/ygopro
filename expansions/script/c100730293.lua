--高速决斗技能-魔术少女们
Duel.LoadScript("speed_duel_common.lua")
function c100730293.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(17896384,c)
	aux.SpeedDuelBeforeDraw(c,c100730293.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730293.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730293.gfilter)
	e1:SetValue(c100730293.val)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730293.gfilter(e,c)
	return c:IsSetCard(0x20a2) and c:IsFaceup()
end
function c100730293.val(e,tp)
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)*100
end
