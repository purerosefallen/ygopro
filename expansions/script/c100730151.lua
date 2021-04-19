--高速决斗技能-轮回封锁
Duel.LoadScript("speed_duel_common.lua")
function c100730151.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730151.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730151.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730151)
	local c=Duel.CreateToken(tp,71442223)
	Duel.SSet(tp,c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730151.tgfilter)
	e1:SetValue(LOCATION_DECKSHF)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730151.tgfilter(e,c)
	return c:IsSetCard(0xe3)
end