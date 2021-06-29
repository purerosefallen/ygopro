--高速决斗技能-魔术少女们
Duel.LoadScript("speed_duel_common.lua")
function c100730034.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(17896384,c)
	aux.SpeedDuelBeforeDraw(c,c100730034.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730034.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730034.gfilter)
	e1:SetValue(c100730034.val)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730034.gfilter(e,c)
	return c:IsSetCard(0x20a2) and c:IsFaceup()
end
function c100730034.val(e,tp)
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)*100
end
