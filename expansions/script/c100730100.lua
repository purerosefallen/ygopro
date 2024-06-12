--高速决斗技能-天赐的宝牌
Duel.LoadScript("speed_duel_common.lua")
function c100730100.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730100.operation,c100730100.con,aux.Stringid(100730100,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100730100.operation)
	c:RegisterEffect(e1)
	aux.SpeedDuelBeforeDraw(c,c100730100.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730100.Isgod(c)
	return c:IsOriginalCodeRule(10000020) and c:IsFaceup()
end

function c100730100.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ht>=6 then return end
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730100.Isgod,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
		and Duel.IsPlayerCanDraw(tp,6-ht)
end

function c100730100.operation(e,tp,eg,ep,ev,re,r,rp)
	local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	local hp=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
	Duel.Hint(HINT_CARD,1-tp,100730100)
	Duel.Draw(tp,6-ht,REASON_RULE)
	if hp<6 then
		Duel.Draw(1-tp,6-hp,REASON_RULE)
	end 
end

function c100730100.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100730100.tgfilter)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(c100730100.imfilter)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end
function c100730100.tgfilter(e,c)
	return c:IsOriginalCodeRule(10000020)
end
function c100730100.imfilter(e,re)
	return re:IsActiveType(TYPE_TRAP)
end
